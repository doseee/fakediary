package com.a101.fakediary.job.stablediffusion;

import com.a101.fakediary.mattermost.MatterMostSender;
import com.a101.fakediary.stablediffusion.api.StableDiffusionApi;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersBuilder;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory;
import org.springframework.batch.core.configuration.annotation.StepBuilderFactory;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.core.launch.support.RunIdIncrementer;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;

import java.time.LocalDateTime;

@Configuration
@EnableBatchProcessing
@RequiredArgsConstructor
@EnableScheduling
@Slf4j
public class StableDiffusionUrlCheckJob implements SchedulingConfigurer  {
    private final JobBuilderFactory jobBuilderFactory;
    private final StepBuilderFactory stepBuilderFactory;
    private final JobLauncher jobLauncher;
    private final StableDiffusionApi stableDiffusionApi;
    private final MatterMostSender matterMostSender;

    @Override
    public void configureTasks(ScheduledTaskRegistrar taskRegistrar) {
        ThreadPoolTaskScheduler taskScheduler = new ThreadPoolTaskScheduler();
        taskScheduler.setPoolSize(10);
        taskScheduler.setThreadNamePrefix("batch-scheduler-");
        taskScheduler.initialize();
        taskRegistrar.setTaskScheduler(taskScheduler);
    }

    @Scheduled(cron = "0 30 * * * *")
    public void runJob() throws Exception {

        Job job = jobBuilderFactory.get("stable-diffusion-url-check-job")
                .incrementer(new RunIdIncrementer())
                .flow(step())
                .end()
                .build();

        jobLauncher.run(job, getJobParameters());
    }

    private Step step() {
        return stepBuilderFactory.get("stable-diffusion-url-check-step")
                .tasklet(tasklet())
                .build();
    }

    private Tasklet tasklet() {
        return (stepContribution, chunkContext) -> {
            try {
                if(!stableDiffusionApi.isUrlAlive()) {
                    log.info("Stable Diffusion is dead!!");
                    //  Stable Diffusion URL이 만료됐을 경우 메시지 보내기
                    matterMostSender.sendMessage(new Exception("Stable Diffusion URL이 만료되었습니다!"), "all");
                }

                log.info("Stable Diffusion is alive!!");
            } catch(Exception e) {
                e.printStackTrace();
            }
            return RepeatStatus.FINISHED;
        };
    }

    //  현재 시각을 이용해서 JobParameters를 생성한다.
    private JobParameters getJobParameters() {
        JobParametersBuilder jobParametersBuilder = new JobParametersBuilder();
        jobParametersBuilder.addString("datetime", LocalDateTime.now().toString());
        return jobParametersBuilder.toJobParameters();
    }
}
