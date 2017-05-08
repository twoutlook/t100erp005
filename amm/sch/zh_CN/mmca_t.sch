/* 
================================================================================
檔案代號:mmca_t
檔案名稱:生效營運據點卡積點除外規則單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mmca_t
(
mmcaent       number(5)      ,/* 企業編號 */
mmcasite       varchar2(10)      ,/* 營運據點 */
mmca001       varchar2(30)      ,/* 活動規則編號 */
mmca002       varchar2(10)      ,/* 卡種編號 */
mmca003       varchar2(10)      ,/* 規則類型 */
mmca004       varchar2(40)      ,/* 規則編碼 */
mmcaacti       varchar2(1)      ,/* 資料有效 */
mmcaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmcaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmcaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmcaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmcaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmcaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmcaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmcaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmcaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmcaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmcaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmcaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmcaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmcaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmcaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmcaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmcaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmcaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmcaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmcaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmcaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmcaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmcaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmcaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmcaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmcaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmcaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmcaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmcaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmcaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmca_t add constraint mmca_pk primary key (mmcaent,mmcasite,mmca001,mmca003,mmca004) enable validate;

create unique index mmca_pk on mmca_t (mmcaent,mmcasite,mmca001,mmca003,mmca004);

grant select on mmca_t to tiptop;
grant update on mmca_t to tiptop;
grant delete on mmca_t to tiptop;
grant insert on mmca_t to tiptop;

exit;
