/* 
================================================================================
檔案代號:fmmn_t
檔案名稱: 沖銷利息子檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmmn_t
(
fmmnent       number(5)      ,/* 企業代碼 */
fmmndocno       varchar2(20)      ,/* 計息單號 */
fmmn001       varchar2(20)      ,/* 投資購買單號 */
fmmn002       varchar2(1)      ,/* 收息來源 */
fmmn003       varchar2(20)      ,/* 收息單號 */
fmmn004       date      ,/* 收息日期 */
fmmn005       number(20,6)      ,/* 沖銷原幣 */
fmmn006       number(20,6)      ,/* 沖銷本幣 */
fmmnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmnud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmmn_t add constraint fmmn_pk primary key (fmmnent,fmmndocno,fmmn001,fmmn003) enable validate;

create unique index fmmn_pk on fmmn_t (fmmnent,fmmndocno,fmmn001,fmmn003);

grant select on fmmn_t to tiptop;
grant update on fmmn_t to tiptop;
grant delete on fmmn_t to tiptop;
grant insert on fmmn_t to tiptop;

exit;
