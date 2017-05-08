/* 
================================================================================
檔案代號:fmce_t
檔案名稱:融資申請單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fmce_t
(
fmceent       number(5)      ,/* 企業代碼 */
fmceownid       varchar2(20)      ,/* 資料所有者 */
fmceowndp       varchar2(10)      ,/* 資料所屬部門 */
fmcecrtid       varchar2(20)      ,/* 資料建立者 */
fmcecrtdp       varchar2(10)      ,/* 資料建立部門 */
fmcecrtdt       timestamp(0)      ,/* 資料創建日 */
fmcemodid       varchar2(20)      ,/* 資料修改者 */
fmcemoddt       timestamp(0)      ,/* 最近修改日 */
fmcecnfid       varchar2(20)      ,/* 資料確認者 */
fmcecnfdt       timestamp(0)      ,/* 資料確認日 */
fmcestus       varchar2(10)      ,/* 狀態碼 */
fmcedocno       varchar2(20)      ,/* 單號 */
fmcesite       varchar2(10)      ,/* 營運據點 */
fmcecomp       varchar2(10)      ,/* 法人 */
fmcedocdt       date      ,/* 單據日期 */
fmceud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmceud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmceud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmceud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmceud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmceud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmceud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmceud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmceud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmceud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmceud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmceud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmceud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmceud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmceud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmceud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmceud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmceud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmceud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmceud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmceud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmceud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmceud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmceud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmceud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmceud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmceud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmceud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmceud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmceud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmce_t add constraint fmce_pk primary key (fmceent,fmcedocno) enable validate;

create unique index fmce_pk on fmce_t (fmceent,fmcedocno);

grant select on fmce_t to tiptop;
grant update on fmce_t to tiptop;
grant delete on fmce_t to tiptop;
grant insert on fmce_t to tiptop;

exit;
