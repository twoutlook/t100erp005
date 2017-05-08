/* 
================================================================================
檔案代號:mmav_t
檔案名稱:卡活動規則生效營運據點檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmav_t
(
mmavent       number(5)      ,/* 企業編號 */
mmavsite       varchar2(10)      ,/* 營運據點 */
mmav001       varchar2(30)      ,/* 活動規則編號 */
mmav002       varchar2(10)      ,/* 活動類型 */
mmav003       varchar2(10)      ,/* 卡種編號 */
mmav004       varchar2(10)      ,/* 生效組織 */
mmav005       varchar2(1)      ,/* 包含組織一下所有營運據點 */
mmav006       varchar2(10)      ,/* 庫位編號 */
mmavstus       varchar2(1)      ,/* 資料有效碼 */
mmavud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmavud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmavud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmavud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmavud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmavud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmavud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmavud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmavud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmavud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmavud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmavud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmavud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmavud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmavud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmavud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmavud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmavud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmavud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmavud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmavud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmavud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmavud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmavud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmavud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmavud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmavud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmavud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmavud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmavud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmav_t add constraint mmav_pk primary key (mmavent,mmavsite,mmav001,mmav004) enable validate;

create unique index mmav_pk on mmav_t (mmavent,mmavsite,mmav001,mmav004);

grant select on mmav_t to tiptop;
grant update on mmav_t to tiptop;
grant delete on mmav_t to tiptop;
grant insert on mmav_t to tiptop;

exit;
