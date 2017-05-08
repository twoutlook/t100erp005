/* 
================================================================================
檔案代號:imad_t
檔案名稱:料件單位換算檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table imad_t
(
imadent       number(5)      ,/* 企業編號 */
imadstus       varchar2(10)      ,/* 狀態碼 */
imad001       varchar2(40)      ,/* 料件編號 */
imad002       varchar2(10)      ,/* 來源單位 */
imad003       number(20,6)      ,/* 來源數量 */
imad004       varchar2(10)      ,/* 目的單位 */
imad005       number(20,6)      ,/* 目的數量 */
imadownid       varchar2(20)      ,/* 資料所有者 */
imadowndp       varchar2(10)      ,/* 資料所屬部門 */
imadcrtid       varchar2(20)      ,/* 資料建立者 */
imadcrtdt       timestamp(0)      ,/* 資料創建日 */
imadcrtdp       varchar2(10)      ,/* 資料建立部門 */
imadmodid       varchar2(20)      ,/* 資料修改者 */
imadmoddt       timestamp(0)      ,/* 最近修改日 */
imadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imadud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imad_t add constraint imad_pk primary key (imadent,imad001,imad002,imad004) enable validate;

create unique index imad_pk on imad_t (imadent,imad001,imad002,imad004);

grant select on imad_t to tiptop;
grant update on imad_t to tiptop;
grant delete on imad_t to tiptop;
grant insert on imad_t to tiptop;

exit;
