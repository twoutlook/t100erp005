/* 
================================================================================
檔案代號:crcg_t
檔案名稱:客戶回訪記錄答案明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table crcg_t
(
crcgent       number(5)      ,/* 企業編號 */
crcgsite       varchar2(10)      ,/* 營運據點 */
crcgunit       varchar2(10)      ,/* 應用組織 */
crcgdocno       varchar2(20)      ,/* 回訪單號 */
crcg001       varchar2(10)      ,/* 問題編號 */
crcg002       varchar2(10)      ,/* 答案編號 */
crcg003       varchar2(1)      ,/* 選擇 */
crcgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
crcgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
crcgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
crcgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
crcgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
crcgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
crcgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
crcgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
crcgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
crcgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
crcgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
crcgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
crcgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
crcgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
crcgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
crcgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
crcgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
crcgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
crcgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
crcgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
crcgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
crcgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
crcgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
crcgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
crcgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
crcgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
crcgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
crcgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
crcgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
crcgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table crcg_t add constraint crcg_pk primary key (crcgent,crcgdocno,crcg001,crcg002) enable validate;

create unique index crcg_pk on crcg_t (crcgent,crcgdocno,crcg001,crcg002);

grant select on crcg_t to tiptop;
grant update on crcg_t to tiptop;
grant delete on crcg_t to tiptop;
grant insert on crcg_t to tiptop;

exit;
