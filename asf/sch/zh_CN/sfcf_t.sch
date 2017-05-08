/* 
================================================================================
檔案代號:sfcf_t
檔案名稱:RunCard拆分記錄單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfcf_t
(
sfcfent       number(5)      ,/* 企業編號 */
sfcfsite       varchar2(10)      ,/* 營運據點 */
sfcfdocno       varchar2(20)      ,/* 工單單號 */
sfcfseq       number(10,0)      ,/* 項次 */
sfcf001       number(10,0)      ,/* 拆分版本 */
sfcf002       varchar2(10)      ,/* 作業編號 */
sfcf003       varchar2(10)      ,/* 作業序 */
sfcf004       number(10,0)      ,/* 新RunCard編號 */
sfcf005       number(20,6)      ,/* 拆分轉入數量 */
sfcfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfcfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfcfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfcfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfcfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfcfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfcfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfcfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfcfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfcfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfcfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfcfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfcfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfcfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfcfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfcfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfcfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfcfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfcfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfcfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfcfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfcfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfcfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfcfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfcfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfcfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfcfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfcfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfcfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfcfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfcf_t add constraint sfcf_pk primary key (sfcfent,sfcfdocno,sfcfseq,sfcf001) enable validate;

create unique index sfcf_pk on sfcf_t (sfcfent,sfcfdocno,sfcfseq,sfcf001);

grant select on sfcf_t to tiptop;
grant update on sfcf_t to tiptop;
grant delete on sfcf_t to tiptop;
grant insert on sfcf_t to tiptop;

exit;
