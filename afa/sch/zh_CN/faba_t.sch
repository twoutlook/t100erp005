/* 
================================================================================
檔案代號:faba_t
檔案名稱:資產異動單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table faba_t
(
fabaent       number(5)      ,/* 企業編號 */
fabadocno       varchar2(20)      ,/* 單據編號 */
fabadocdt       date      ,/* 單據日期 */
fabasite       varchar2(10)      ,/* 資產中心 */
fabacomp       varchar2(10)      ,/* 法人 */
faba001       varchar2(20)      ,/* 帳務人員 */
faba002       varchar2(20)      ,/* No Use */
faba003       number(10)      ,/* 單據性質 */
fabastus       varchar2(1)      ,/* 確認碼 */
fabaownid       varchar2(20)      ,/* 資料所有者 */
fabaowndp       varchar2(10)      ,/* 資料所屬部門 */
fabacrtid       varchar2(20)      ,/* 資料建立者 */
fabacrtdp       varchar2(10)      ,/* 資料建立部門 */
fabacrtdt       timestamp(0)      ,/* 資料創建日 */
fabamodid       varchar2(20)      ,/* 資料修改者 */
fabamoddt       timestamp(0)      ,/* 最近修改日 */
fabacnfid       varchar2(20)      ,/* 資料確認者 */
fabacnfdt       timestamp(0)      ,/* 資料確認日 */
fabaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fabaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fabaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fabaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fabaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fabaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fabaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fabaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fabaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fabaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fabaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fabaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fabaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fabaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fabaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fabaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fabaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fabaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fabaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fabaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fabaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fabaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fabaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fabaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fabaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fabaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fabaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fabaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fabaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fabaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
faba004       varchar2(20)      ,/* 申請人員 */
faba005       varchar2(10)      ,/* 申請部門 */
faba006       date      ,/* 申請日期 */
faba007       varchar2(20)      ,/* 解除文號 */
faba008       date      /* 解除日期 */
);
alter table faba_t add constraint faba_pk primary key (fabaent,fabadocno) enable validate;

create unique index faba_pk on faba_t (fabaent,fabadocno);

grant select on faba_t to tiptop;
grant update on faba_t to tiptop;
grant delete on faba_t to tiptop;
grant insert on faba_t to tiptop;

exit;
