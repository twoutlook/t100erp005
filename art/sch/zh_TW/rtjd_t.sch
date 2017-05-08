/* 
================================================================================
檔案代號:rtjd_t
檔案名稱:銷售整合含稅檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table rtjd_t
(
rtjdent       number(5)      ,/* 企業編號 */
rtjdsite       varchar2(10)      ,/* 營運據點 */
rtjdunit       varchar2(10)      ,/* 應用組織 */
rtjddocno       varchar2(20)      ,/* 單據編號 */
rtjdseq       number(10,0)      ,/* 項次 */
rtjdseq1       number(10,0)      ,/* 稅別序 */
rtjd001       varchar2(10)      ,/* 稅別 */
rtjd002       number(5,2)      ,/* 稅率 */
rtjd003       varchar2(1)      ,/* 含稅 */
rtjd004       number(20,6)      ,/* 固定稅額 */
rtjd005       number(20,6)      ,/* 稅額 */
rtjdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtjdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtjdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtjdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtjdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtjdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtjdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtjdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtjdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtjdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtjdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtjdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtjdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtjdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtjdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtjdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtjdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtjdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtjdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtjdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtjdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtjdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtjdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtjdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtjdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtjdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtjdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtjdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtjdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtjdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtjd_t add constraint rtjd_pk primary key (rtjdent,rtjddocno,rtjdseq,rtjdseq1) enable validate;

create unique index rtjd_pk on rtjd_t (rtjdent,rtjddocno,rtjdseq,rtjdseq1);

grant select on rtjd_t to tiptop;
grant update on rtjd_t to tiptop;
grant delete on rtjd_t to tiptop;
grant insert on rtjd_t to tiptop;

exit;
