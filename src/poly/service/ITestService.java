package poly.service;

import java.util.List;

import poly.dto.TestDTO;

public interface ITestService {
	
	int getTestInfoFromWEB() throws Exception;

	List<TestDTO> getTestInfo(TestDTO pDTO) throws Exception;
}
