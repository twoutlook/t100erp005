/* 
================================================================================
檔案代號:imau_t
檔案名稱:條碼資訊明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imau_t
(
imauent       number(5)      ,/* 企業編號 */
imausite       varchar2(10)      ,/* 營運據點 */
imauseq       number(10,0)      ,/* 項次 */
imau000       number(5,0)      ,/* 版次 */
imau001       varchar2(40)      ,/* 條碼編號 */
imau002       varchar2(10)      ,/* 庫位 */
imau003       varchar2(10)      ,/* 儲位 */
imau004       varchar2(30)      ,/* 批號 */
imau005       varchar2(30)      ,/* 製造批號 */
imau006       varchar2(30)      ,/* 製造序號 */
imau007       number(20,6)      ,/* 庫存數量 */
imauud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imauud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imauud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imauud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imauud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imauud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imauud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imauud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imauud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imauud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imauud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imauud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imauud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imauud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imauud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imauud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imauud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imauud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imauud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imauud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imauud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imauud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imauud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imauud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imauud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imauud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imauud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imauud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imauud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imauud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imau_t add constraint imau_pk primary key (imauent,imauseq,imau000,imau001) enable validate;

create unique index imau_pk on imau_t (imauent,imauseq,imau000,imau001);

grant select on imau_t to tiptop;
grant update on imau_t to tiptop;
grant delete on imau_t to tiptop;
grant insert on imau_t to tiptop;

exit;
