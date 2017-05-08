/* 
================================================================================
檔案代號:srae_t
檔案名稱:重覆性生產計畫製程上站作業檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table srae_t
(
sraeent       number(5)      ,/* 企業編號 */
sraesite       varchar2(10)      ,/* 營運據點 */
srae001       varchar2(10)      ,/* 生產計劃 */
srae002       varchar2(10)      ,/* 製程編號 */
srae004       varchar2(40)      ,/* 料件編號 */
srae005       varchar2(30)      ,/* BOM特性 */
srae006       varchar2(256)      ,/* 產品特徵 */
srae007       number(10,0)      ,/* 項次 */
sraeseq       number(10,0)      ,/* 項序 */
srae008       varchar2(10)      ,/* 上站作業 */
srae009       varchar2(10)      ,/* 上站制程序 */
sraeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sraeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sraeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sraeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sraeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sraeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sraeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sraeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sraeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sraeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sraeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sraeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sraeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sraeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sraeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sraeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sraeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sraeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sraeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sraeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sraeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sraeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sraeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sraeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sraeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sraeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sraeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sraeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sraeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sraeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table srae_t add constraint srae_pk primary key (sraeent,sraesite,srae001,srae002,srae004,srae005,srae006,srae007,sraeseq) enable validate;

create unique index srae_pk on srae_t (sraeent,sraesite,srae001,srae002,srae004,srae005,srae006,srae007,sraeseq);

grant select on srae_t to tiptop;
grant update on srae_t to tiptop;
grant delete on srae_t to tiptop;
grant insert on srae_t to tiptop;

exit;
