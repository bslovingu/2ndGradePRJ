package poly.service;

import java.util.List;

import poly.dto.RankDTO;
import poly.dto.SearchDTO;
import poly.dto.ValueDTO;

public interface INaverRankService {

	List<RankDTO> collectNaverRank(ValueDTO pDTO) throws Exception;

	List<String> getRelKeyword(String keyword) throws Exception;

}
