package com.a101.fakediary.job;

import lombok.RequiredArgsConstructor;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory;
import org.springframework.batch.core.configuration.annotation.JobScope;
import org.springframework.batch.core.configuration.annotation.StepBuilderFactory;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.core.launch.support.RunIdIncrementer;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

@Configuration
@RequiredArgsConstructor
public class HelloWorldJobConfig {
    private final JobBuilderFactory jobBuilderFactory;
    private final StepBuilderFactory stepBuilderFactory;

    //  job
    @Bean
    public Job helloWorldJob() {
        return jobBuilderFactory.get("helloWorldJob")   //  job 이름
                .incrementer(new RunIdIncrementer())    //  job id 순차적으로 부여
                .start(helloWorldStep())
                .build();
    }

    //  step
    @JobScope
    @Bean
    public Step helloWorldStep() {
        return  stepBuilderFactory.get("helloWorldStep")
                .tasklet(helloWorldTasklet())  //  따로 읽고 쓸 게 없는 단순한 작업할 때
                .build();
    }

    @StepScope
    @Bean
    public Tasklet helloWorldTasklet() {
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("Hello World Spring Batch");
                return RepeatStatus.FINISHED;   //  이 스텝이 끝났음을  알림
            }
        };
    }
}
