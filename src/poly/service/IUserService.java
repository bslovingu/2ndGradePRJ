package poly.service;

import java.util.List;

import poly.dto.UserDTO;
import poly.dto.UserListDTO;

public interface IUserService {

	int insertUserInfo(UserDTO pDTO) throws Exception;

	int ckeckId(UserDTO pDTO) throws Exception;

	int ckeckMail(UserDTO pDTO) throws Exception;

	UserDTO getLogin(UserDTO uDTO) throws Exception;

	int updateUserInfo(UserDTO pDTO) throws Exception;

	UserDTO getIdInfo(UserDTO pDTO) throws Exception;

	UserDTO getPwInfo(UserDTO pDTO) throws Exception;

	int updatePwInfo(UserDTO pDTO) throws Exception;

	UserDTO getUserInfo(UserDTO pDTO) throws Exception;

	int modifyAuthor(UserDTO pDTO) throws Exception;

	int deleteUserInfo(UserDTO pDTO) throws Exception;

	List<UserDTO> getUserList(UserListDTO pDTO) throws Exception;

	int getTotal(UserListDTO pDTO) throws Exception;

	void importData(List<String> rList)throws Exception;

}
