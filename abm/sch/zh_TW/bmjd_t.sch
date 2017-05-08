/* 
================================================================================
檔案代號:bmjd_t
檔案名稱:ECR木板維護變更後影響事項檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmjd_t
(
bmjdent       number(5)      ,/* 企業編號 */
bmjdsite       varchar2(10)      ,/* 營運據點 */
bmjdseq       number(10,0)      ,/* 項次 */
bmjdseq1       varchar2(10)      ,/* 項序 */
bmjd001       varchar2(10)      ,/* 模板編號 */
bmjd002       varchar2(10)      ,/* 影響類型 */
bmjd003       varchar2(10)      ,/* 影響內容 */
bmjd004       varchar2(1)      ,/* 回覆值類型 */
bmjdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmjdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmjdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmjdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmjdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmjdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmjdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmjdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmjdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmjdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmjdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmjdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmjdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmjdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmjdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmjdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmjdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmjdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmjdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmjdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmjdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmjdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmjdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmjdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmjdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmjdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmjdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmjdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmjdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmjdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmjd_t add constraint bmjd_pk primary key (bmjdent,bmjdseq,bmjdseq1,bmjd001) enable validate;

create unique index bmjd_pk on bmjd_t (bmjdent,bmjdseq,bmjdseq1,bmjd001);

grant select on bmjd_t to tiptop;
grant update on bmjd_t to tiptop;
grant delete on bmjd_t to tiptop;
grant insert on bmjd_t to tiptop;

exit;
