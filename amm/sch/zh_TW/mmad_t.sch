/* 
================================================================================
檔案代號:mmad_t
檔案名稱:會員基本資料申請檔-訊息喜好類型
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmad_t
(
mmadent       number(5)      ,/* 企業編號 */
mmaddocno       varchar2(20)      ,/* 單據編號 */
mmad001       varchar2(30)      ,/* 會員編號 */
mmad002       varchar2(10)      ,/* 喜好類型代碼 */
mmadacti       varchar2(10)      ,/* 資料有效碼 */
mmadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmadud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmad_t add constraint mmad_pk primary key (mmadent,mmaddocno,mmad002) enable validate;

create  index mmad_01 on mmad_t (mmad002);
create unique index mmad_pk on mmad_t (mmadent,mmaddocno,mmad002);

grant select on mmad_t to tiptop;
grant update on mmad_t to tiptop;
grant delete on mmad_t to tiptop;
grant insert on mmad_t to tiptop;

exit;
