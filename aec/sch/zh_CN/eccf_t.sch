/* 
================================================================================
檔案代號:eccf_t
檔案名稱:料件製程check in/out項目資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table eccf_t
(
eccfent       number(5)      ,/* 企業代碼 */
eccfsite       varchar2(10)      ,/* 營運據點 */
eccfdocno       varchar2(20)      ,/* 申請單號 */
eccf001       varchar2(40)      ,/* 製程料號 */
eccf002       varchar2(10)      ,/* 製程編號 */
eccf003       number(10,0)      ,/* 製程項次 */
eccfseq       number(10,0)      ,/* 項序 */
eccf004       varchar2(1)      ,/* check in/check out */
eccf005       varchar2(10)      ,/* 項目 */
eccf006       varchar2(1)      ,/* 形態 */
eccf007       number(15,3)      ,/* 下限 */
eccf008       number(15,3)      ,/* 上限 */
eccf009       varchar2(80)      ,/* 預設值 */
eccf010       varchar2(1)      ,/* 必要 */
eccf900       number(10,0)      ,/* 變更序 */
eccf901       varchar2(1)      ,/* 變更類型 */
eccf902       date      ,/* 變更日期 */
eccf905       varchar2(10)      ,/* 變更原因 */
eccf906       varchar2(255)      ,/* 變更備註 */
eccfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
eccfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
eccfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
eccfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
eccfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
eccfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
eccfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
eccfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
eccfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
eccfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
eccfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
eccfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
eccfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
eccfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
eccfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
eccfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
eccfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
eccfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
eccfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
eccfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
eccfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
eccfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
eccfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
eccfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
eccfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
eccfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
eccfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
eccfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
eccfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
eccfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table eccf_t add constraint eccf_pk primary key (eccfent,eccfsite,eccfdocno,eccf003,eccfseq) enable validate;

create unique index eccf_pk on eccf_t (eccfent,eccfsite,eccfdocno,eccf003,eccfseq);

grant select on eccf_t to tiptop;
grant update on eccf_t to tiptop;
grant delete on eccf_t to tiptop;
grant insert on eccf_t to tiptop;

exit;
