package com.a101.fakediary.music.entity;

import com.a101.fakediary.common.BaseEntity;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDate;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@Entity
public class Music extends BaseEntity {
    @SequenceGenerator(
            name = "MEMBER_SEQ_GEN",
            sequenceName = "MEMBER_SEQ",
            initialValue = 100,
            allocationSize = 1
    )
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "MEMBER_SEQ_GEN")
    @Column(name = "music_id")
    private Long musicId;

    @Column(name = "file_name", unique = true, nullable = false)
    private String fileName;

    @Column(name = "music_url", unique = true, nullable = false)
    private String musicUrl;

    @Column(nullable = false)
    private String mood;

    @Column(name = "upload_date", nullable = false)
    private LocalDate uploadDate;
}
