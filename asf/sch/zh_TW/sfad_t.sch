/* 
================================================================================
檔案代號:sfad_t
檔案名稱:工單單頭特徵檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfad_t
(
sfadent       number(5)      ,/* 企業編號 */
sfadsite       varchar2(10)      ,/* 營運據點 */
sfaddocno       varchar2(20)      ,/* 單號 */
sfad001       varchar2(256)      ,/* 特徵 */
sfad002       number(20,6)      ,/* 數量 */
sfad003       number(20,6)      ,/* 己完工數量 */
sfadseq       number(10,0)      ,/* 項次 */
sfadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfadud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfad_t add constraint sfad_pk primary key (sfadent,sfaddocno,sfadseq) enable validate;

create unique index sfad_pk on sfad_t (sfadent,sfaddocno,sfadseq);

grant select on sfad_t to tiptop;
grant update on sfad_t to tiptop;
grant delete on sfad_t to tiptop;
grant insert on sfad_t to tiptop;

exit;
