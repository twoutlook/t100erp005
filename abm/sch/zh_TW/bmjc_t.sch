/* 
================================================================================
檔案代號:bmjc_t
檔案名稱:ECR模板維護現存資料影響檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmjc_t
(
bmjcent       number(5)      ,/* 企業編號 */
bmjcsite       varchar2(10)      ,/* 營運據點 */
bmjcseq       number(10,0)      ,/* 項次 */
bmjc001       varchar2(10)      ,/* 模板編號 */
bmjc002       varchar2(10)      ,/* 影響類型 */
bmjcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmjcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmjcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmjcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmjcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmjcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmjcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmjcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmjcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmjcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmjcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmjcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmjcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmjcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmjcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmjcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmjcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmjcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmjcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmjcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmjcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmjcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmjcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmjcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmjcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmjcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmjcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmjcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmjcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmjcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmjc_t add constraint bmjc_pk primary key (bmjcent,bmjcseq,bmjc001) enable validate;

create unique index bmjc_pk on bmjc_t (bmjcent,bmjcseq,bmjc001);

grant select on bmjc_t to tiptop;
grant update on bmjc_t to tiptop;
grant delete on bmjc_t to tiptop;
grant insert on bmjc_t to tiptop;

exit;
