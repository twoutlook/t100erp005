/* 
================================================================================
檔案代號:bgcf_t
檔案名稱:模擬收入變量主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgcf_t
(
bgcfent       number(5)      ,/* 企業編號 */
bgcf001       varchar2(10)      ,/* 變數編號 */
bgcfseq       number(10,0)      ,/* 項次 */
bgcf002       varchar2(1)      ,/* 左括號 */
bgcf003       varchar2(10)      ,/* 計價因子 */
bgcf004       varchar2(1)      ,/* 右括號 */
bgcf005       varchar2(10)      ,/* 運算符號 */
bgcfownid       varchar2(20)      ,/* 資料所有者 */
bgcfowndp       varchar2(10)      ,/* 資料所屬部門 */
bgcfcrtid       varchar2(20)      ,/* 資料建立者 */
bgcfcrtdp       varchar2(10)      ,/* 資料建立部門 */
bgcfcrtdt       timestamp(0)      ,/* 資料創建日 */
bgcfmodid       varchar2(20)      ,/* 資料修改者 */
bgcfmoddt       timestamp(0)      ,/* 最近修改日 */
bgcfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bgcfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bgcfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bgcfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bgcfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bgcfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bgcfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bgcfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bgcfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bgcfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bgcfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bgcfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bgcfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bgcfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bgcfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bgcfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bgcfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bgcfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bgcfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bgcfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bgcfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bgcfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bgcfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bgcfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bgcfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bgcfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bgcfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bgcfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bgcfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bgcfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bgcf_t add constraint bgcf_pk primary key (bgcfent,bgcf001,bgcfseq) enable validate;

create unique index bgcf_pk on bgcf_t (bgcfent,bgcf001,bgcfseq);

grant select on bgcf_t to tiptop;
grant update on bgcf_t to tiptop;
grant delete on bgcf_t to tiptop;
grant insert on bgcf_t to tiptop;

exit;
