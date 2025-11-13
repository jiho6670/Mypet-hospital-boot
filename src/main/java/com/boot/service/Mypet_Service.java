package com.boot.service;

import java.util.HashMap;
import java.util.List;

import com.boot.dto.GroomingResDTO;
import com.boot.dto.MedicalResDTO;
import com.boot.dto.Mypet_NoticesDTO;
import com.boot.dto.Mypet_PetDTO;
import com.boot.dto.Mypet_Qna_BoardDTO;
import com.boot.dto.Mypet_UserDTO;

public interface Mypet_Service {

    /* ===================== [ USER ] ===================== */
    void join(Mypet_UserDTO dto);
    Object login(HashMap<String, Object> map);
    void updateUserInfo(HashMap<String, Object> map);
    Mypet_UserDTO getUserByNo(int user_no);

    /* ===================== [ PET ] ===================== */
    void petjoin(Mypet_PetDTO petDTO);
    void updatePetInfo(HashMap<String, Object> map);
    Mypet_PetDTO getPetInfo(int user_no, int pet_no);
    List<Mypet_PetDTO> getPetsByUserNo(int user_no);
    Mypet_PetDTO getPetByNo(int pet_no);

    /* ===================== [ 예약 (미용/진료) ] ===================== */
    List<GroomingResDTO> findGroomingReservations(HashMap<String, String> map);
    void createGroomingReservation(GroomingResDTO dto);

    List<MedicalResDTO> findMedicalReservations(HashMap<String, String> map);
    void createMedicalReservation(MedicalResDTO dto);

    /* ===================== [ 이미지 업로드 ] ===================== */
    boolean uploadUserImage(int user_no, String fileName, byte[] fileBytes);
    boolean uploadPetImage(int pet_no, String fileName, byte[] fileBytes);

    /* ===================== [ 비밀번호 찾기 ] ===================== */
    boolean checkUserExists(HashMap<String, String> map);
    boolean updatePassword(HashMap<String, String> map);

    /* ===================== [ 공지사항 ] ===================== */
    List<Mypet_NoticesDTO> getNoticesList();
    Mypet_NoticesDTO getNoticeDetail(int notice_no);
    void writeNotice(Mypet_NoticesDTO dto);
    void modifyNotice(Mypet_NoticesDTO dto);
    void deleteNotice(int notice_no);
    void increaseNoticeViewCount(int notice_no);

    List<Mypet_NoticesDTO> list(HashMap<String, Object> map);
    int getTotalCount();

    /* ===================== [ QnA 기능 ] ===================== */
    List<Mypet_Qna_BoardDTO> getQnaList();
    void writeQna(Mypet_Qna_BoardDTO dto);
    Mypet_Qna_BoardDTO getQnaDetail(int qna_no);

    List<Mypet_Qna_BoardDTO> list2(HashMap<String, Object> map);
    int getTotalCount2();
}
