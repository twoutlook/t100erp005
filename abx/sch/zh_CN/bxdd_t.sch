/* 
================================================================================
檔案代號:bxdd_t
檔案名稱:保稅機器設備記帳卡單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bxdd_t
(
bxddent       number(5)      ,/* 企業編號 */
bxddsite       varchar2(10)      ,/* 營運據點 */
bxdd001       varchar2(10)      ,/* 記帳卡編號 */
bxdd002       varchar2(80)      ,/* 記帳卡名稱 */
bxdd003       varchar2(20)      ,/* 負責人 */
bxdd004       varchar2(20)      ,/* 承辦人 */
bxdd005       varchar2(255)      ,/* 備註 */
bxddownid       varchar2(20)      ,/* 資料所有者 */
bxddowndp       varchar2(10)      ,/* 資料所屬部門 */
bxddcrtid       varchar2(20)      ,/* 資料建立者 */
bxddcrtdp       varchar2(10)      ,/* 資料建立部門 */
bxddcrtdt       timestamp(0)      ,/* 資料創建日 */
bxddmodid       varchar2(20)      ,/* 資料修改者 */
bxddmoddt       timestamp(0)      ,/* 最近修改日 */
bxddcnfid       varchar2(20)      ,/* 資料確認者 */
bxddcnfdt       timestamp(0)      ,/* 資料確認日 */
bxddstus       varchar2(10)      ,/* 狀態碼 */
bxddud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxddud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxddud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxddud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxddud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxddud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxddud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxddud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxddud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxddud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxddud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxddud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxddud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxddud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxddud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxddud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxddud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxddud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxddud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxddud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxddud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxddud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxddud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxddud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxddud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxddud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxddud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxddud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxddud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxddud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxdd_t add constraint bxdd_pk primary key (bxddent,bxddsite,bxdd001) enable validate;

create unique index bxdd_pk on bxdd_t (bxddent,bxddsite,bxdd001);

grant select on bxdd_t to tiptop;
grant update on bxdd_t to tiptop;
grant delete on bxdd_t to tiptop;
grant insert on bxdd_t to tiptop;

exit;
