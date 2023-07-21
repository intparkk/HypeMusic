package com.study.springboot.controller;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontFormatException;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartFrame;
import org.jfree.chart.ChartUtils;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.data.category.DefaultCategoryDataset;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletResponse;


@Controller
public class hjs_machinelearning_controller {

	@RequestMapping("/hjs_img_chart")
	public String chart() {
		System.out.println("차트 성공");
		return "";
	}
	
	
	@Value("${font.path}")
	private String fontPath;

	
	// 가수별 평균 좋아요 수  // 막대그래프
	@RequestMapping("/hjs_chart_likecount")
	public void likecount_chart(HttpServletResponse response) {
	    // 가수별 좋아요 수의 평균 데이터를 담을 데이터셋 생성
	    DefaultCategoryDataset dataset = new DefaultCategoryDataset();

	    // 데이터베이스 연결
	    try (Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@1.247.146.31:51521/xe", "hypemusic", "hype1234")) {
	        // SQL 쿼리 실행
	        String query = "select * from (SELECT artist, AVG(like_COUNT) AS L_c FROM tb_music GROUP BY artist ORDER BY L_c desc)where rownum <=11";
	        Statement statement = connection.createStatement();
	        ResultSet resultSet = statement.executeQuery(query);

	        // 결과셋에서 데이터 추출하여 데이터셋에 추가
	        while (resultSet.next()) {
	            String artist = resultSet.getString("artist");
	            if (artist != null) { // artist 값이 null이 아닌 경우에만 데이터셋에 추가
	                double avgLikes = resultSet.getDouble("L_c");
	                dataset.addValue(avgLikes, "평균 좋아요 수", artist);
	            }
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

	        // 그래프 색상 변경
	        CategoryPlot plot = chart.getCategoryPlot();
	        BarRenderer renderer = (BarRenderer) plot.getRenderer();
	        renderer.setSeriesPaint(0, Color.yellow); // 첫 번째 데이터셋의 막대 색상을 파란색으로 설정

	        // 이미지 데이터 생성
	        int width = 1000;
	        int height = 400;
	        byte[] chartImage = null;
	        try {
	            chartImage = ChartUtils.encodeAsPNG(chart.createBufferedImage(width, height));
	        } catch (IOException e) {
	            e.printStackTrace();
	        }

	        // 폰트 객체 생성
	        Font customFont;
	        customFont = new Font("NotoSansKR-Medium", Font.PLAIN, 12);

	        // 폰트 설정
	        chart.getTitle().setFont(customFont); // 차트 제목 폰트 설정
	        chart.getLegend().setItemFont(customFont); // 범례 폰트 설정
	        CategoryPlot plot2 = (CategoryPlot) chart.getPlot();
	        plot.getDomainAxis().setLabelFont(customFont); // x축 레이블 폰트 설정
	        plot.getRangeAxis().setLabelFont(customFont); // y축 레이블 폰트 설정
	        plot.getRenderer().setDefaultItemLabelFont(customFont); // 데이터 레이블 폰트 설정

	        // 이미지를 PNG 형식으로 출력
	        response.setContentType("image/png");
	        try (OutputStream outputStream = response.getOutputStream()) {
	            outputStream.write(chartImage);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	
}	
	
	
	@RequestMapping("/hjs_chart")
	public String chart2() {
		return "hjs_chart_artist";
	}
	
	
	
	// 가수별 좋아요수 변화량 선그래프
	@RequestMapping("/hjs_chart_artist")
	public String chart_artist(
			 @RequestParam("artist") String artist,
			HttpServletResponse response
			) {
		
		 // 가수별 좋아요 수 데이터셋 생성
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();

        // 데이터베이스 연결
        try (Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@1.247.146.31:51521/xe", "hypemusic", "hype1234")) {
            // SQL 쿼리 실행
            String query = "SELECT LIKE_COUNT,release_date FROM TB_MUSIC WHERE artist Like '%'||?||'%' ORDER BY release_date ASC";
            
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, artist); // Bind the artist parameter with the provided value

            ResultSet resultSet = statement.executeQuery();

            
            
            // 결과셋에서 데이터 추출하여 데이터셋에 추가
            while (resultSet.next()) {
                String release_date = resultSet.getString("release_date");
                int likeCount = resultSet.getInt("LIKE_COUNT");
                dataset.addValue(likeCount, "좋아요 수", release_date);
            }

            // 선 그래프 생성
            JFreeChart chart = ChartFactory.createLineChart(
                    "like_count change",   // 차트 제목
                    "release_date",        // x축 레이블
                    "like_count",          // y축 레이블
                    dataset                // 데이터셋
            );

            // 그래프 스타일 설정 SansSerif
            chart.getTitle().setFont(new Font("Papyrus", Font.BOLD, 16));
            chart.getLegend().setItemFont(new Font("Papyrus", Font.PLAIN, 12));
            chart.getPlot().setBackgroundPaint(Color.WHITE);

            // 이미지 데이터 생성
            int width = 800;
            int height = 600;
            byte[] chartImage = null;
			try {
				chartImage = ChartUtils.encodeAsPNG(chart.createBufferedImage(width, height));
			} catch (IOException e) {
				e.printStackTrace();
			}

            // 이미지를 HTTP 응답으로 출력
            response.setContentType("image/png");
            try (OutputStream outputStream = response.getOutputStream()) {
                if (chartImage != null) {
                    outputStream.write(chartImage);
                    outputStream.flush();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
           }
		
		return "redirect:/hjs_chart";
	}



}




