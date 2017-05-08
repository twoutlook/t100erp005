/* 
================================================================================
檔案代號:gzzm_t
檔案名稱:Javamail外寄主機與程式對照表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzzm_t
(
gzzm001       varchar2(20)      ,/* 作業編號 */
gzzm002       varchar2(1)      ,/* 外寄伺服器使用加密類型 */
gzzm003       varchar2(20)      ,/* 外寄郵件伺服器(SMTP) IP */
gzzm004       number(5)      ,/* 外寄郵件伺服器(SMTP) Port */
gzzm005       varchar2(80)      ,/* 登入使用者名稱 */
gzzm006       varchar2(80)      ,/* 登入使用者密碼 */
gzzm007       varchar2(1)      ,/* 外寄伺服器(SMTP)需要驗證 */
gzzm008       varchar2(1)      ,/* 系統寄件者(TIPTOP) */
gzzm009       varchar2(1)      ,/* 回條 */
gzzment       number(5)      ,/* 企業編號 */
gzzmownid       varchar2(20)      ,/* 資料所有者 */
gzzmowndp       varchar2(10)      ,/* 資料所屬部門 */
gzzmcrtid       varchar2(20)      ,/* 資料建立者 */
gzzmcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzzmcrtdt       timestamp(0)      ,/* 資料創建日 */
gzzmmodid       varchar2(20)      ,/* 資料修改者 */
gzzmmoddt       timestamp(0)      ,/* 最近修改日 */
gzzmstus       varchar2(10)      ,/* 狀態碼 */
gzzm010       varchar2(80)      ,/* 限定寄件者 E-Mail */
gzzmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzzmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzzmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzzmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzzmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzzmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzzmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzzmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzzmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzzmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzzmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzzmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzzmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzzmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzzmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzzmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzzmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzzmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzzmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzzmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzzmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzzmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzzmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzzmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzzmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzzmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzzmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzzmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzzmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzzmud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
gzzm011       varchar2(1)      /* 附件加密碼 */
);
alter table gzzm_t add constraint gzzm_pk primary key (gzzm001,gzzment) enable validate;

create unique index gzzm_pk on gzzm_t (gzzm001,gzzment);

grant select on gzzm_t to tiptop;
grant update on gzzm_t to tiptop;
grant delete on gzzm_t to tiptop;
grant insert on gzzm_t to tiptop;

exit;
