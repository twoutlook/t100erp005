/* 
================================================================================
檔案代號:prfk_t
檔案名稱:客戶定價客戶組資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prfk_t
(
prfkent       number(5)      ,/* 企業編號 */
prfkunit       varchar2(10)      ,/* 應用組織 */
prfksite       varchar2(10)      ,/* 營運據點 */
prfkdocno       varchar2(20)      ,/* 申請單號 */
prfkseq       number(10,0)      ,/* 項次 */
prfk001       varchar2(10)      ,/* 客戶類型 */
prfk002       varchar2(10)      ,/* 客戶組編號 */
prfkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prfkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prfkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prfkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prfkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prfkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prfkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prfkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prfkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prfkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prfkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prfkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prfkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prfkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prfkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prfkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prfkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prfkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prfkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prfkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prfkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prfkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prfkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prfkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prfkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prfkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prfkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prfkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prfkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prfkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prfk_t add constraint prfk_pk primary key (prfkent,prfkdocno,prfkseq) enable validate;

create unique index prfk_pk on prfk_t (prfkent,prfkdocno,prfkseq);

grant select on prfk_t to tiptop;
grant update on prfk_t to tiptop;
grant delete on prfk_t to tiptop;
grant insert on prfk_t to tiptop;

exit;
