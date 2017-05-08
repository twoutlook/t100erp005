/* 
================================================================================
檔案代號:fmcv_t
檔案名稱:償還本息單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fmcv_t
(
fmcvent       number(5)      ,/* 企業編號 */
fmcvdocno       varchar2(20)      ,/* 還款單號 */
fmcvsite       varchar2(10)      ,/* 資金中心 */
fmcvcomp       varchar2(10)      ,/* 法人 */
fmcvdocdt       date      ,/* 還款日期 */
fmcvownid       varchar2(20)      ,/* 資料所屬者 */
fmcvowndp       varchar2(10)      ,/* 資料所屬部門 */
fmcvcrtid       varchar2(20)      ,/* 資料建立者 */
fmcvcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmcvcrtdt       timestamp(0)      ,/* 資料創建日 */
fmcvmodid       varchar2(20)      ,/* 資料修改者 */
fmcvmoddt       timestamp(0)      ,/* 最近修改日 */
fmcvcnfid       varchar2(20)      ,/* 資料確認者 */
fmcvcnfdt       timestamp(0)      ,/* 資料確認日 */
fmcvstus       varchar2(10)      ,/* 狀態碼 */
fmcvud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmcvud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmcvud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmcvud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmcvud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmcvud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmcvud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmcvud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmcvud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmcvud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmcvud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmcvud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmcvud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmcvud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmcvud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmcvud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmcvud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmcvud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmcvud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmcvud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmcvud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmcvud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmcvud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmcvud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmcvud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmcvud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmcvud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmcvud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmcvud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmcvud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmcv_t add constraint fmcv_pk primary key (fmcvent,fmcvdocno) enable validate;

create unique index fmcv_pk on fmcv_t (fmcvent,fmcvdocno);

grant select on fmcv_t to tiptop;
grant update on fmcv_t to tiptop;
grant delete on fmcv_t to tiptop;
grant insert on fmcv_t to tiptop;

exit;
