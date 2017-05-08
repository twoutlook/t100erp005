/* 
================================================================================
檔案代號:ecbe_t
檔案名稱:料件製程上站作業資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table ecbe_t
(
ecbeent       number(5)      ,/* 企業編號 */
ecbesite       varchar2(10)      ,/* 營運據點 */
ecbe001       varchar2(40)      ,/* 製程料號 */
ecbe002       varchar2(10)      ,/* 製程編號 */
ecbe003       number(10,0)      ,/* 製程項次 */
ecbeseq       number(10,0)      ,/* 項序 */
ecbe004       varchar2(10)      ,/* 上站作業 */
ecbe005       varchar2(10)      ,/* 上站作業序 */
ecbeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ecbeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ecbeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ecbeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ecbeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ecbeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ecbeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ecbeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ecbeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ecbeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ecbeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ecbeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ecbeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ecbeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ecbeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ecbeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ecbeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ecbeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ecbeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ecbeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ecbeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ecbeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ecbeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ecbeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ecbeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ecbeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ecbeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ecbeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ecbeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ecbeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ecbe_t add constraint ecbe_pk primary key (ecbeent,ecbesite,ecbe001,ecbe002,ecbe003,ecbeseq) enable validate;

create unique index ecbe_pk on ecbe_t (ecbeent,ecbesite,ecbe001,ecbe002,ecbe003,ecbeseq);

grant select on ecbe_t to tiptop;
grant update on ecbe_t to tiptop;
grant delete on ecbe_t to tiptop;
grant insert on ecbe_t to tiptop;

exit;
