/* 
================================================================================
檔案代號:ecba_t
檔案名稱:料件製程單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table ecba_t
(
ecbaent       number(5)      ,/* 企業編號 */
ecbasite       varchar2(10)      ,/* 營運據點 */
ecbaownid       varchar2(20)      ,/* 資料所有者 */
ecbaowndp       varchar2(10)      ,/* 資料所屬部門 */
ecbacrtid       varchar2(20)      ,/* 資料建立者 */
ecbacrtdp       varchar2(10)      ,/* 資料建立部門 */
ecbacrtdt       timestamp(0)      ,/* 資料創建日 */
ecbamodid       varchar2(20)      ,/* 資料修改者 */
ecbamoddt       timestamp(0)      ,/* 最近修改日 */
ecbacnfid       varchar2(20)      ,/* 資料確認者 */
ecbacnfdt       timestamp(0)      ,/* 資料確認日 */
ecbastus       varchar2(10)      ,/* 狀態碼 */
ecba001       varchar2(40)      ,/* 製程料號 */
ecba002       varchar2(10)      ,/* 製程編號 */
ecba003       varchar2(80)      ,/* 說明 */
ecbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ecbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ecbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ecbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ecbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ecbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ecbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ecbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ecbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ecbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ecbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ecbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ecbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ecbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ecbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ecbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ecbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ecbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ecbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ecbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ecbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ecbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ecbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ecbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ecbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ecbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ecbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ecbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ecbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ecbaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
ecba004       number(5,0)      ,/* 起始X軸 */
ecba005       number(5,0)      ,/* 起始Y軸 */
ecba006       number(5,0)      ,/* 截止X軸 */
ecba007       number(5,0)      /* 截止Y軸 */
);
alter table ecba_t add constraint ecba_pk primary key (ecbaent,ecbasite,ecba001,ecba002) enable validate;

create unique index ecba_pk on ecba_t (ecbaent,ecbasite,ecba001,ecba002);

grant select on ecba_t to tiptop;
grant update on ecba_t to tiptop;
grant delete on ecba_t to tiptop;
grant insert on ecba_t to tiptop;

exit;
