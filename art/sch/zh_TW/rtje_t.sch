/* 
================================================================================
檔案代號:rtje_t
檔案名稱:銷售整合收款檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table rtje_t
(
rtjeent       number(5)      ,/* 企業編號 */
rtjesite       varchar2(10)      ,/* 營運據點 */
rtjeunit       varchar2(10)      ,/* 應用組織 */
rtjedocno       varchar2(20)      ,/* 單據編號 */
rtjeseq       number(10,0)      ,/* 項次 */
rtjeseq1       number(10,0)      ,/* 收款序 */
rtje001       varchar2(10)      ,/* 款別分類 */
rtje002       varchar2(10)      ,/* 款別編號 */
rtje003       number(20,6)      ,/* 收款金額 */
rtje004       number(20,6)      ,/* 票券溢收款金額 */
rtje005       number(20,6)      ,/* 找零金額 */
rtje006       number(20,6)      ,/* 實收金額 */
rtje007       number(15,3)      ,/* 抵現積分 */
rtjeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtjeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtjeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtjeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtjeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtjeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtjeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtjeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtjeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtjeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtjeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtjeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtjeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtjeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtjeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtjeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtjeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtjeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtjeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtjeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtjeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtjeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtjeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtjeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtjeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtjeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtjeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtjeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtjeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtjeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtje_t add constraint rtje_pk primary key (rtjeent,rtjedocno,rtjeseq,rtjeseq1) enable validate;

create unique index rtje_pk on rtje_t (rtjeent,rtjedocno,rtjeseq,rtjeseq1);

grant select on rtje_t to tiptop;
grant update on rtje_t to tiptop;
grant delete on rtje_t to tiptop;
grant insert on rtje_t to tiptop;

exit;
