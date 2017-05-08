/* 
================================================================================
檔案代號:bmkd_t
檔案名稱:ECR申請單變更後影響事項檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmkd_t
(
bmkdent       number(5)      ,/* 企業編號 */
bmkdsite       varchar2(10)      ,/* 營運據點 */
bmkddocno       varchar2(20)      ,/* 申請單號 */
bmkdseq       number(10,0)      ,/* 項次 */
bmkdseq1       varchar2(10)      ,/* 項序 */
bmkd001       varchar2(10)      ,/* 影響類型 */
bmkd002       varchar2(10)      ,/* 影響內容 */
bmkd003       varchar2(1)      ,/* 回覆值 */
bmkd004       varchar2(80)      ,/* 說明 */
bmkdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmkdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmkdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmkdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmkdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmkdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmkdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmkdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmkdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmkdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmkdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmkdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmkdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmkdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmkdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmkdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmkdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmkdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmkdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmkdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmkdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmkdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmkdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmkdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmkdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmkdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmkdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmkdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmkdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmkdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmkd_t add constraint bmkd_pk primary key (bmkdent,bmkddocno,bmkdseq,bmkdseq1) enable validate;

create unique index bmkd_pk on bmkd_t (bmkdent,bmkddocno,bmkdseq,bmkdseq1);

grant select on bmkd_t to tiptop;
grant update on bmkd_t to tiptop;
grant delete on bmkd_t to tiptop;
grant insert on bmkd_t to tiptop;

exit;
