package poly.persistance.mongo;

import java.util.List;

import poly.dto.MelonDTO;
import poly.dto.MelonSingerDTO;
import poly.dto.MelonSongDTO;

public interface IMelonMapper {
   /**
    * MongoDB 컬랙션 생성하기
    * 
    * @param colNm 생성하는 컬렉션 이름
    */
   public boolean createCollection(String colNm) throws Exception;

   /**
    * MongoDB 데이터 저장하기
    * 
    * @param pDTO 저장될 정보
    */
   public int insertRank(List<MelonDTO> pList, String colNm) throws Exception;

   /**
    * MongoDB 멜론 데이터 가져오기
    * 
    * @param colNm 가져올 컬랙션 이름
    */
   public List<MelonDTO> getRank(String colNm) throws Exception;

   /**
    * MongoDB 가수의 노래 데이터 가져오기
    * 
    * @param colNm  가져올 컬랙션 이름
    * @param singer 가수 이름
    */
   public List<MelonSongDTO> getSongForSinger(String colNm, String singer) throws Exception;
   
   /**
    * MongoDB 가수별 멜론 랭킹에 많이 등록된 순서대로 가져오기
    */
   public List<MelonSingerDTO> getRankForSinger(String colNm) throws Exception;
}