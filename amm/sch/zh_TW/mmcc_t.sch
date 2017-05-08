/* 
================================================================================
檔案代號:mmcc_t
檔案名稱:卡儲值加值一般規則申請單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmcc_t
(
mmccent       number(5)      ,/* 企業編號 */
mmccsite       varchar2(10)      ,/* 營運據點 */
mmccunit       varchar2(10)      ,/* 應用組織 */
mmccdocno       varchar2(20)      ,/* 單據編號 */
mmcc001       varchar2(30)      ,/* 活動規則編號 */
mmcc002       varchar2(10)      ,/* 卡種編號 */
mmcc003       varchar2(10)      ,/* 規則類型 */
mmcc004       varchar2(40)      ,/* 規則編碼 */
mmcc005       number(20,6)      ,/* 儲值基準額滿 */
mmcc006       number(20,6)      ,/* 單位儲值基準 */
mmcc007       number(20,6)      ,/* 單位加值金額 */
mmcc008       number(5,0)      ,/* 儲值折扣率% */
mmccacti       varchar2(1)      ,/* 有效 */
mmccud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmccud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmccud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmccud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmccud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmccud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmccud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmccud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmccud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmccud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmccud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmccud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmccud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmccud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmccud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmccud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmccud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmccud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmccud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmccud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmccud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmccud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmccud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmccud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmccud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmccud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmccud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmccud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmccud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmccud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
mmcc009       varchar2(10)      /* 加值類型 */
);
alter table mmcc_t add constraint mmcc_pk primary key (mmccent,mmccdocno,mmcc003,mmcc004) enable validate;

create unique index mmcc_pk on mmcc_t (mmccent,mmccdocno,mmcc003,mmcc004);

grant select on mmcc_t to tiptop;
grant update on mmcc_t to tiptop;
grant delete on mmcc_t to tiptop;
grant insert on mmcc_t to tiptop;

exit;
