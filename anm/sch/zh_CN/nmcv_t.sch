/* 
================================================================================
檔案代號:nmcv_t
檔案名稱:資金計劃審批主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:Y
============.========================.==========================================
 */
create table nmcv_t
(
nmcvent       number(5)      ,/* 企業編號 */
nmcvdocno       varchar2(20)      ,/* 計劃編製單號 */
nmcvdocdt       date      ,/* 審批日期 */
nmcv001       varchar2(10)      ,/* 審批單位 */
nmcvstus       varchar2(1)      ,/* 狀態碼 */
nmcvownid       varchar2(20)      ,/* 資料所有者 */
nmcvowndp       varchar2(10)      ,/* 資料所屬部門 */
nmcvcrtid       varchar2(20)      ,/* 資料建立者 */
nmcvcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmcvcrtdt       timestamp(0)      ,/* 資料創建日 */
nmcvmodid       varchar2(20)      ,/* 資料修改者 */
nmcvmoddt       timestamp(0)      ,/* 最近修改日 */
nmcvcnfid       varchar2(20)      ,/* 資料確認者 */
nmcvcnfdt       timestamp(0)      ,/* 資料確認日 */
nmcvud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmcvud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmcvud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmcvud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmcvud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmcvud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmcvud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmcvud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmcvud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmcvud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmcvud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmcvud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmcvud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmcvud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmcvud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmcvud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmcvud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmcvud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmcvud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmcvud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmcvud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmcvud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmcvud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmcvud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmcvud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmcvud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmcvud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmcvud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmcvud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmcvud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmcv_t add constraint nmcv_pk primary key (nmcvent,nmcvdocno,nmcv001) enable validate;

create unique index nmcv_pk on nmcv_t (nmcvent,nmcvdocno,nmcv001);

grant select on nmcv_t to tiptop;
grant update on nmcv_t to tiptop;
grant delete on nmcv_t to tiptop;
grant insert on nmcv_t to tiptop;

exit;
