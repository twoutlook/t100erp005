/* 
================================================================================
檔案代號:inpo_t
檔案名稱:存貨周轉率單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table inpo_t
(
inpoent       number(5)      ,/* 企業編號 */
inposite       varchar2(10)      ,/* 營運據點 */
inpo001       varchar2(10)      ,/* 計算原則編號 */
inpo002       varchar2(80)      ,/* 說明 */
inpo003       varchar2(1)      ,/* 計算類別 */
inpo004       varchar2(1)      ,/* 存貨基礎 */
inpo005       varchar2(1)      ,/* 計算區間 */
inpostus       varchar2(10)      ,/* 狀態碼 */
inpoownid       varchar2(20)      ,/* 資料所有者 */
inpoowndp       varchar2(10)      ,/* 資料所屬部門 */
inpocrtid       varchar2(20)      ,/* 資料建立者 */
inpocrtdp       varchar2(10)      ,/* 資料建立部門 */
inpocrtdt       timestamp(0)      ,/* 資料創建日 */
inpomodid       varchar2(20)      ,/* 資料修改者 */
inpomoddt       timestamp(0)      ,/* 最近修改日 */
inpoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inpoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inpoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inpoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inpoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inpoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inpoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inpoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inpoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inpoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inpoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inpoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inpoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inpoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inpoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inpoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inpoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inpoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inpoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inpoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inpoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inpoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inpoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inpoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inpoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inpoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inpoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inpoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inpoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inpoud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
inpo006       varchar2(1)      ,/* 存貨週轉率目標設定方式 */
inpo007       number(20,6)      /* 存貨週轉率目標 */
);
alter table inpo_t add constraint inpo_pk primary key (inpoent,inposite,inpo001) enable validate;

create unique index inpo_pk on inpo_t (inpoent,inposite,inpo001);

grant select on inpo_t to tiptop;
grant update on inpo_t to tiptop;
grant delete on inpo_t to tiptop;
grant insert on inpo_t to tiptop;

exit;
