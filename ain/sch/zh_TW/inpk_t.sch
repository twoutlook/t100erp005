/* 
================================================================================
檔案代號:inpk_t
檔案名稱:週期盤點限定庫位檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inpk_t
(
inpkent       number(5)      ,/* 企業編號 */
inpksite       varchar2(10)      ,/* 營運據點 */
inpkdocno       varchar2(20)      ,/* 計劃單號 */
inpkseq       number(10,0)      ,/* 項次 */
inpk001       varchar2(10)      ,/* 庫位 */
inpk002       varchar2(255)      ,/* 備註 */
inpkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inpkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inpkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inpkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inpkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inpkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inpkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inpkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inpkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inpkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inpkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inpkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inpkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inpkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inpkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inpkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inpkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inpkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inpkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inpkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inpkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inpkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inpkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inpkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inpkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inpkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inpkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inpkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inpkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inpkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inpk_t add constraint inpk_pk primary key (inpkent,inpksite,inpkdocno,inpkseq) enable validate;

create unique index inpk_pk on inpk_t (inpkent,inpksite,inpkdocno,inpkseq);

grant select on inpk_t to tiptop;
grant update on inpk_t to tiptop;
grant delete on inpk_t to tiptop;
grant insert on inpk_t to tiptop;

exit;
