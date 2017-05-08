/* 
================================================================================
檔案代號:sfkd_t
檔案名稱:工單變更單單頭特徵檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfkd_t
(
sfkdent       number(5)      ,/* 企業編號 */
sfkdsite       varchar2(10)      ,/* 營運據點 */
sfkddocno       varchar2(20)      ,/* 工單單號 */
sfkdseq       number(10,0)      ,/* 項次 */
sfkd001       varchar2(256)      ,/* 特徵 */
sfkd002       number(20,6)      ,/* 數量 */
sfkd003       number(20,6)      ,/* 己完工數量 */
sfkd900       number(10,0)      ,/* 變更序 */
sfkd901       varchar2(1)      ,/* 變更類型 */
sfkd902       date      ,/* 變更日期 */
sfkd905       varchar2(10)      ,/* 變更理由 */
sfkd906       varchar2(255)      ,/* 變更備註 */
sfkdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfkdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfkdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfkdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfkdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfkdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfkdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfkdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfkdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfkdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfkdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfkdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfkdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfkdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfkdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfkdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfkdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfkdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfkdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfkdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfkdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfkdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfkdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfkdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfkdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfkdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfkdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfkdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfkdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfkdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfkd_t add constraint sfkd_pk primary key (sfkdent,sfkddocno,sfkdseq,sfkd900) enable validate;

create unique index sfkd_pk on sfkd_t (sfkdent,sfkddocno,sfkdseq,sfkd900);

grant select on sfkd_t to tiptop;
grant update on sfkd_t to tiptop;
grant delete on sfkd_t to tiptop;
grant insert on sfkd_t to tiptop;

exit;
