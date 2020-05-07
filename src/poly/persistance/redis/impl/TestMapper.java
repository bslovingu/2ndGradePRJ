package poly.persistance.redis.impl;

import java.util.Iterator;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.stereotype.Component;

import poly.dto.MovieDTO;
import poly.dto.TestDTO;
import poly.persistance.redis.IRedisTestMapper;

@Component("TestMapper")
public class TestMapper implements IRedisTestMapper {
	
	@Autowired
	public RedisTemplate<String, Object> redisDB;
	

	private Logger log = Logger.getLogger(this.getClass());
	
	@Override
	public boolean getExists(String key) throws Exception {
		log.info(this.getClass().getName() + ".getExists Start!");
		return redisDB.hasKey(key);
	}

	@Override
	public List<TestDTO> getTestInfo(String key) throws Exception {
		log.info(this.getClass().getName() + ".getTestInfo Start!");

		List<TestDTO> rList = null;

		redisDB.setKeySerializer(new StringRedisSerializer());
		redisDB.setValueSerializer(new Jackson2JsonRedisSerializer<>(TestDTO.class));

		if (redisDB.hasKey(key)) {
			rList = (List) redisDB.opsForList().range(key, 0, -1);
		}

		log.info(this.getClass().getName() + ".getTestInfo End!");

		return rList;
	}

	@Override
	public int setTestInfo(String key, List<TestDTO> pList) throws Exception {
		log.info(this.getClass().getName() + ".setTestInfo Start!");

		int res = 0;

		redisDB.setKeySerializer(new StringRedisSerializer());
		redisDB.setValueSerializer(new Jackson2JsonRedisSerializer<>(MovieDTO.class));

		if (this.getExists(key)) {
			redisDB.delete(key);
		}

		Iterator<TestDTO> it = pList.iterator();

		while (it.hasNext()) {
			TestDTO pDTO = (TestDTO) it.next();
			redisDB.opsForList().rightPush(key, pDTO);
			pDTO = null;
		}
		res = 1;
		
		log.info(this.getClass().getName() + ".setTestInfo End!");
		
		return res;
	}

	@Override
	public boolean setTimeOutHour(String key, int hours) throws Exception {
		log.info(this.getClass().getName() + ".setTimeOutHour Start!");
		return redisDB.expire(key, hours, TimeUnit.HOURS);
	}

	@Override
	public List<TestDTO> getTestInfo(TestDTO pDTO) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int InsertTestInfo(TestDTO pDTO) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

}
