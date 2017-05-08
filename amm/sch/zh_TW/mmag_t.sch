/* 
================================================================================
檔案代號:mmag_t
檔案名稱:會員基本資料檔-屬性資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmag_t
(
mmagent       number(5)      ,/* 企業編號 */
mmag001       varchar2(30)      ,/* 會員編號 */
mmag002       varchar2(10)      ,/* 屬性代碼類別 */
mmag003       varchar2(10)      ,/* 對應應用分類代碼 */
mmag004       varchar2(10)      ,/* 屬性代碼值 */
mmagstus       varchar2(10)      ,/* 有效碼 */
mmagud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmagud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmagud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmagud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmagud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmagud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmagud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmagud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmagud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmagud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmagud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmagud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmagud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmagud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmagud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmagud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmagud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmagud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmagud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmagud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmagud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmagud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmagud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmagud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmagud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmagud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmagud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmagud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmagud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmagud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmag_t add constraint mmag_pk primary key (mmagent,mmag001,mmag002,mmag003) enable validate;

create unique index mmag_pk on mmag_t (mmagent,mmag001,mmag002,mmag003);

grant select on mmag_t to tiptop;
grant update on mmag_t to tiptop;
grant delete on mmag_t to tiptop;
grant insert on mmag_t to tiptop;

exit;
