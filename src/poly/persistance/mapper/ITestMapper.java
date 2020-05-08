package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.TestDTO;

@Mapper("mysqlTestMapper")
public interface ITestMapper {

	// 수집된 내용 DB에 등록
	int InsertTestInfo(TestDTO pDTO) throws Exception;

	// 수집된 데이터 조회
	List<TestDTO> getTestInfo(TestDTO pDTO) throws Exception;

	boolean getExists(String key) throws Exception;

}
