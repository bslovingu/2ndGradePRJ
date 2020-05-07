package poly.persistance.redis;

import java.util.List;

import poly.dto.TestDTO;

public interface IRedisTestMapper {
	// 날씨정보 존재하는지 확인
	public boolean getExists(String key) throws Exception;

	// 날씨정보 가져오기
	public List<TestDTO> getTestInfo(TestDTO pDTO) throws Exception;

	// 날씨정보 저장
	public int setTestInfo(String key, List<TestDTO> pList) throws Exception;

	// 날씨정보 저장 ttl설정
	public boolean setTimeOutHour(String key, int hours) throws Exception;

	public List<TestDTO> getTestInfo(String key) throws Exception;

	public int InsertTestInfo(TestDTO pDTO) throws Exception;
}
