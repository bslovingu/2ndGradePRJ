package poly.service;

import java.util.List;

import poly.dto.DataDTO;
import poly.dto.NewsDTO;

public interface INaverNewsService {

	List<NewsDTO> collectNaverNews(String keyword) throws Exception;

	List<DataDTO> analysisData(List<NewsDTO> rList, String user_id, String keyword) throws Exception;

}
