package com.boot.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.boot.dto.Mypet_UserDTO;
import com.boot.dto.GroomingResDTO;
import com.boot.dto.MedicalResDTO;
import com.boot.dto.Mypet_AdminDTO;
import com.boot.dto.Mypet_NoticesDTO;
import com.boot.dto.Mypet_PetDTO;
import com.boot.dto.Mypet_Qna_BoardDTO;

@Mapper
public interface Mypet_DAO {

    /* ===================== [ USER (회원) 관련 ] ===================== */

    void join(Mypet_UserDTO dto);

    Integer loginFindNo(HashMap<String, Object> map);

    Mypet_UserDTO selectUserByNo(int no);
    Mypet_AdminDTO selectAdminByNo(int no);

    void updateUserInfo(HashMap<String, Object> map);

    int checkUserExists(HashMap<String, String> map);
    int updatePassword(HashMap<String, String> map);

    /* ===================== [ PET (펫) 관련 ] ===================== */

    List<Mypet_PetDTO> selectPetsByUserNo(HashMap<String, Object> map);

    Mypet_PetDTO getPetInfo(HashMap<String, Object> map);

    void petjoin(Mypet_PetDTO petDTO);

    int updatePetInfo(HashMap<String, Object> map);

    int checkDuplicateUserImage(String img_temp);
    int checkDuplicatePetImage(String img_temp);
    void updateUserImage(HashMap<String, Object> map);
    void updatePetImage(HashMap<String, Object> map);

    List<GroomingResDTO> findGroomingReservations(HashMap<String, String> map);
    void createGroomingReservation(GroomingResDTO dto);
    Mypet_PetDTO getPetByNo(int pet_no);

    List<MedicalResDTO> findMedicalReservations(HashMap<String, String> map);
    void createMedicalReservation(MedicalResDTO dto);

    /* ===================== [ NOTICE (공지사항) 관련 ] ===================== */

    List<Mypet_NoticesDTO> selectNotices();
    Mypet_NoticesDTO selectNoticeByNo(int notice_no);
    void insertNotice(Mypet_NoticesDTO dto);
    void updateNotice(Mypet_NoticesDTO dto);
    void increaseViewCount(int notice_no);
    void deleteNotice(int notice_no);

    List<Mypet_NoticesDTO> list(HashMap<String, Object> map);
    int getTotalCount();

    /* ===================== [ QNA 관련 ] ===================== */

    List<Mypet_Qna_BoardDTO> getQnaList();
    void writeQna(Mypet_Qna_BoardDTO dto);
    Mypet_Qna_BoardDTO getQnaDetail(int qna_no);

    List<Mypet_Qna_BoardDTO> list2(HashMap<String, Object> map);
    int getTotalCount2();
}
