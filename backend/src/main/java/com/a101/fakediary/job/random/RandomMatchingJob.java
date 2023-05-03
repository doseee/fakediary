package com.a101.fakediary.job.random;

import com.a101.fakediary.randomexchangepool.service.RandomExchangePoolService;
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
public class RandomMatchingJob implements SchedulingConfigurer {
    private final JobBuilderFactory jobBuilderFactory;
    private final StepBuilderFactory stepBuilderFactory;
    private final JobLauncher jobLauncher;
    private final RandomExchangePoolService randomExchangePoolService;

    @Override
    public void configureTasks(ScheduledTaskRegistrar taskRegistrar) {
        ThreadPoolTaskScheduler taskScheduler = new ThreadPoolTaskScheduler();
        taskScheduler.setPoolSize(10);
        taskScheduler.setThreadNamePrefix("batch-scheduler-");
        taskScheduler.initialize();
        taskRegistrar.setTaskScheduler(taskScheduler);
    }

    @Scheduled(cron = "0 23 15 * * *")
    public void runJob() throws Exception {

        Job job = jobBuilderFactory.get("random-exchange-job")
                .incrementer(new RunIdIncrementer())
                .flow(step())
                .end()
                .build();

        jobLauncher.run(job, getJobParameters());
    }

    private Step step() {
        return stepBuilderFactory.get("random-exchange-step")
                .tasklet(tasklet())
                .build();
    }

    private Tasklet tasklet() {
        return (stepContribution, chunkContext) -> {
            randomExchangePoolService.doRandomMatching();
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
