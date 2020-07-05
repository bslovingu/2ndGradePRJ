package poly.persistance.mongo;

import java.util.List;

import poly.dto.MelonDTO;
import poly.dto.MongoDataDTO;

public interface IMongoTestMapper {
	public boolean createCollection(String colNm) throws Exception;
	public int insertData(MongoDataDTO mDTO, String colNm) throws Exception;
}
