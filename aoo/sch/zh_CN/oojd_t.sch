/* 
================================================================================
檔案代號:oojd_t
檔案名稱:渠道基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oojd_t
(
oojdent       number(5)      ,/* 企業編號 */
oojd001       varchar2(10)      ,/* 渠道編號 */
oojd002       varchar2(10)      ,/* 渠道類型 */
oojd003       varchar2(10)      ,/* 渠道分類 */
oojd004       varchar2(10)      ,/* 渠道性質 */
oojdownid       varchar2(20)      ,/* 資料所有者 */
oojdowndp       varchar2(10)      ,/* 資料所屬部門 */
oojdcrtid       varchar2(20)      ,/* 資料建立者 */
oojdcrtdp       varchar2(10)      ,/* 資料建立部門 */
oojdcrtdt       timestamp(0)      ,/* 資料創建日 */
oojdmodid       varchar2(20)      ,/* 資料修改者 */
oojdmoddt       timestamp(0)      ,/* 最近修改日 */
oojdstus       varchar2(10)      ,/* 狀態碼 */
oojdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oojdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oojdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oojdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oojdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oojdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oojdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oojdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oojdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oojdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oojdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oojdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oojdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oojdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oojdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oojdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oojdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oojdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oojdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oojdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oojdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oojdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oojdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oojdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oojdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oojdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oojdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oojdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oojdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oojdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oojd_t add constraint oojd_pk primary key (oojdent,oojd001) enable validate;

create unique index oojd_pk on oojd_t (oojdent,oojd001);

grant select on oojd_t to tiptop;
grant update on oojd_t to tiptop;
grant delete on oojd_t to tiptop;
grant insert on oojd_t to tiptop;

exit;
