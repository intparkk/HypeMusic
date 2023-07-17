package com.study.springboot.machine_learning;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.apache.commons.io.output.ByteArrayOutputStream;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtils;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;

public class hjs_chart_likecount {

	 public static void main(String[] args) {
	        // 가수별 좋아요 수의 평균 데이터 (가상의 데이터)
	        String[] artists = {"가수 A", "가수 B", "가수 C", "가수 D"};
	        double[] avgLikes = {1000, 2000, 1500, 3000};

	        // 데이터셋 생성
	        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
	        for (int i = 0; i < artists.length; i++) {
	            dataset.addValue(avgLikes[i], "평균 좋아요 수", artists[i]);
	        }

	        // 막대 그래프 생성
	        JFreeChart chart = ChartFactory.createBarChart(
	                "가수별 평균 좋아요 수",   // 차트 제목
	                "가수",                  // x축 레이블
	                "평균 좋아요 수",        // y축 레이블
	                dataset,                // 데이터셋
	                PlotOrientation.VERTICAL, // 차트 방향
	                true,                   // 범례 표시 여부
	                true,                   // 도구 팁 표시 여부
	                false                   // URL 링크 표시 여부
	        );

	        // 그래프 이미지 파일로 저장
	        File imageFile = new File("chart.png");
	        try {
	            ChartUtils.saveChartAsPNG(imageFile, chart, 600, 400);
	            System.out.println("차트 이미지 저장 완료");
	        
	            // 이미지 파일의 URL 출력
	            String imageUrl = imageFile.toURI().toString();
	            System.out.println("차트 이미지 URL: " + imageUrl);

	        
	        } catch (IOException e) {
	            System.err.println("차트 이미지 저장 실패: " + e.getMessage());
	        }
	    }
	    
	}
