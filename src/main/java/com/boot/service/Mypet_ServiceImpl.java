package com.boot.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.boot.dao.Mypet_DAO;
import com.boot.dto.GroomingResDTO;
import com.boot.dto.MedicalResDTO;
import com.boot.dto.Mypet_AdminDTO;
import com.boot.dto.Mypet_NoticesDTO;
import com.boot.dto.Mypet_PetDTO;
import com.boot.dto.Mypet_Qna_BoardDTO;
import com.boot.dto.Mypet_UserDTO;
import com.boot.util.ImageHashUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class Mypet_ServiceImpl implements Mypet_Service {

    private final Mypet_DAO dao;

    /* ===================== [ USER ] ===================== */

    @Override
    public void join(Mypet_UserDTO dto) {
        dao.join(dto);
    }

    @Override
    public Object login(HashMap<String, Object> map) {
        Integer no = dao.loginFindNo(map);

        if (no == null) return null;

        if (no >= 10001) return null;

        if (no >= 5001) {
            Mypet_AdminDTO admin = dao.selectAdminByNo(no);
            return admin;
        }

        if (no >= 1) {
            Mypet_UserDTO user = dao.selectUserByNo(no);

            if (user != null) {
                HashMap<String, Object> petsMap = new HashMap<>();
                petsMap.put("user_no", user.getUser_no());
                user.setPets(dao.selectPetsByUserNo(petsMap));
            }

            return user;
        }

        return null;
    }

    @Override
    public void updateUserInfo(HashMap<String, Object> map) {
        dao.updateUserInfo(map);
    }

    @Override
    public Mypet_UserDTO getUserByNo(int user_no) {
        return dao.selectUserByNo(user_no);
    }

    /* ===================== [ PET ] ===================== */

    @Override
    @Transactional
    public void petjoin(Mypet_PetDTO petDTO) {
        dao.petjoin(petDTO);
    }

    @Override
    public void updatePetInfo(HashMap<String, Object> map) {
        dao.updatePetInfo(map);
    }

    @Override
    public Mypet_PetDTO getPetInfo(int user_no, int pet_no) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("user_no", user_no);
        map.put("pet_no", pet_no);
        return dao.getPetInfo(map);
    }

    @Override
    public List<Mypet_PetDTO> getPetsByUserNo(int user_no) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("user_no", user_no);
        return dao.selectPetsByUserNo(map);
    }

    @Override
    public Mypet_PetDTO getPetByNo(int pet_no) {
        return dao.getPetByNo(pet_no);
    }

    /* ===================== [ 예약 ] ===================== */

    @Override
    public List<GroomingResDTO> findGroomingReservations(HashMap<String, String> map) {
        return dao.findGroomingReservations(map);
    }

    @Override
    @Transactional
    public void createGroomingReservation(GroomingResDTO dto) {
        dao.createGroomingReservation(dto);
    }

    @Override
    public List<MedicalResDTO> findMedicalReservations(HashMap<String, String> map) {
        return dao.findMedicalReservations(map);
    }

    @Override
    @Transactional
    public void createMedicalReservation(MedicalResDTO dto) {
        dao.createMedicalReservation(dto);
    }

    /* ===================== [ IMAGE ] ===================== */

    @Override
    public boolean uploadUserImage(int user_no, String fileName, byte[] fileBytes) {
        try {
            String hash = ImageHashUtil.getReadableHash(fileBytes);
            if (dao.checkDuplicateUserImage(hash) > 0) return false;

            HashMap<String, Object> map = new HashMap<>();
            map.put("user_no", user_no);
            map.put("user_img", "/resources/upload/user/" + fileName);
            map.put("user_img_temp", hash);

            dao.updateUserImage(map);
            return true;

        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public boolean uploadPetImage(int pet_no, String fileName, byte[] fileBytes) {
        try {
            String hash = ImageHashUtil.getReadableHash(fileBytes);
            if (dao.checkDuplicatePetImage(hash) > 0) return false;

            HashMap<String, Object> map = new HashMap<>();
            map.put("pet_no", pet_no);
            map.put("pet_img", "/resources/upload/pet/" + fileName);
            map.put("pet_img_temp", hash);

            dao.updatePetImage(map);
            return true;

        } catch (Exception e) {
            return false;
        }
    }

    /* ===================== [ PASSWORD ] ===================== */

    @Override
    public boolean checkUserExists(HashMap<String, String> map) {
        return dao.checkUserExists(map) == 1;
    }

    @Override
    public boolean updatePassword(HashMap<String, String> map) {
        return dao.updatePassword(map) == 1;
    }

    /* ===================== [ NOTICE ] ===================== */

    @Override
    public List<Mypet_NoticesDTO> getNoticesList() {
        return dao.selectNotices();
    }

    @Override
    public Mypet_NoticesDTO getNoticeDetail(int notice_no) {
        dao.increaseViewCount(notice_no);
        return dao.selectNoticeByNo(notice_no);
    }

    @Override
    public void writeNotice(Mypet_NoticesDTO dto) {
        dao.insertNotice(dto);
    }

    @Override
    public void modifyNotice(Mypet_NoticesDTO dto) {
        dao.updateNotice(dto);
    }

    @Override
    public void deleteNotice(int notice_no) {
        dao.deleteNotice(notice_no);
    }

    @Override
    public void increaseNoticeViewCount(int notice_no) {
        dao.increaseViewCount(notice_no);
    }

    @Override
    public List<Mypet_NoticesDTO> list(HashMap<String, Object> map) {
        return dao.list(map);
    }

    @Override
    public int getTotalCount() {
        return dao.getTotalCount();
    }

    /* ===================== [ QNA ] ===================== */

    @Override
    public List<Mypet_Qna_BoardDTO> getQnaList() {
        return dao.getQnaList();
    }

    @Override
    @Transactional
    public void writeQna(Mypet_Qna_BoardDTO dto) {
        dao.writeQna(dto);
    }

    @Override
    public Mypet_Qna_BoardDTO getQnaDetail(int qna_no) {
        return dao.getQnaDetail(qna_no);
    }

    @Override
    public List<Mypet_Qna_BoardDTO> list2(HashMap<String, Object> map) {
        return dao.list2(map);
    }

    @Override
    public int getTotalCount2() {
        return dao.getTotalCount2();
    }
}
