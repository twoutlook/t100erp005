/* 
================================================================================
檔案代號:eccc_t
檔案名稱:料件製程變更用料底稿
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table eccc_t
(
ecccent       number(5)      ,/* 企業代碼 */
ecccsite       varchar2(10)      ,/* 營運據點 */
ecccdocno       varchar2(20)      ,/* 申請單號 */
eccc001       varchar2(40)      ,/* 製程料號 */
eccc002       varchar2(10)      ,/* 製程編號 */
eccc003       number(10,0)      ,/* 製程項次 */
eccc004       number(10,0)      ,/* 項次 */
eccc005       varchar2(40)      ,/* 元件料號 */
eccc006       varchar2(10)      ,/* 部位 */
eccc007       number(20,6)      ,/* 組成用量 */
eccc008       number(20,6)      ,/* 主件底數 */
eccc009       varchar2(10)      ,/* 用量單位 */
eccc010       varchar2(1)      ,/* 損耗率形態 */
eccc900       number(10,0)      ,/* 變更序 */
eccc901       varchar2(1)      ,/* 變更類型 */
eccc902       date      ,/* 變更日期 */
eccc905       varchar2(10)      ,/* 變更理由 */
eccc906       varchar2(255)      ,/* 變更備註 */
ecccud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ecccud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ecccud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ecccud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ecccud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ecccud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ecccud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ecccud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ecccud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ecccud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ecccud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ecccud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ecccud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ecccud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ecccud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ecccud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ecccud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ecccud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ecccud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ecccud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ecccud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ecccud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ecccud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ecccud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ecccud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ecccud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ecccud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ecccud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ecccud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ecccud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table eccc_t add constraint eccc_pk primary key (ecccent,ecccsite,ecccdocno,eccc003,eccc004) enable validate;

create unique index eccc_pk on eccc_t (ecccent,ecccsite,ecccdocno,eccc003,eccc004);

grant select on eccc_t to tiptop;
grant update on eccc_t to tiptop;
grant delete on eccc_t to tiptop;
grant insert on eccc_t to tiptop;

exit;
