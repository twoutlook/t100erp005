/* 
================================================================================
檔案代號:imec_t
檔案名稱:料件特徵群組特徵值檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imec_t
(
imecent       number(5)      ,/* 企業編號 */
imec001       varchar2(40)      ,/* 特徵群組代碼 */
imec002       number(10,0)      ,/* 單身項次 */
imec003       varchar2(30)      ,/* 特徵值 */
imecud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imecud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imecud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imecud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imecud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imecud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imecud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imecud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imecud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imecud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imecud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imecud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imecud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imecud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imecud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imecud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imecud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imecud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imecud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imecud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imecud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imecud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imecud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imecud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imecud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imecud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imecud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imecud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imecud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imecud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imec_t add constraint imec_pk primary key (imecent,imec001,imec002,imec003) enable validate;

create unique index imec_pk on imec_t (imecent,imec001,imec002,imec003);

grant select on imec_t to tiptop;
grant update on imec_t to tiptop;
grant delete on imec_t to tiptop;
grant insert on imec_t to tiptop;

exit;
