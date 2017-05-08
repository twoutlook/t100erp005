/* 
================================================================================
檔案代號:deao_t
檔案名稱:營業款寄送存繳單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table deao_t
(
deaoent       number(5)      ,/* 企業編號 */
deaosite       varchar2(10)      ,/* 營運據點 */
deaounit       varchar2(10)      ,/* 應用組織 */
deaodocno       varchar2(20)      ,/* 存繳單號 */
deaodocdt       date      ,/* 單據日期 */
deao001       varchar2(20)      ,/* 存繳人員 */
deaoownid       varchar2(20)      ,/* 資料所有者 */
deaoowndp       varchar2(10)      ,/* 資料所屬部門 */
deaocrtid       varchar2(20)      ,/* 資料建立者 */
deaocrtdp       varchar2(10)      ,/* 資料建立部門 */
deaocrtdt       timestamp(0)      ,/* 資料創建日 */
deaomodid       varchar2(20)      ,/* 資料修改者 */
deaomoddt       timestamp(0)      ,/* 最近修改日 */
deaostus       varchar2(10)      ,/* 狀態碼 */
deaocnfid       varchar2(20)      ,/* 資料確認者 */
deaocnfdt       timestamp(0)      ,/* 資料確認日 */
deaoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deaoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deaoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deaoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deaoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deaoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deaoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deaoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deaoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deaoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deaoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deaoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deaoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deaoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deaoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deaoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deaoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deaoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deaoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deaoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deaoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deaoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deaoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deaoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deaoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deaoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deaoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deaoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deaoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deaoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table deao_t add constraint deao_pk primary key (deaoent,deaodocno) enable validate;

create unique index deao_pk on deao_t (deaoent,deaodocno);

grant select on deao_t to tiptop;
grant update on deao_t to tiptop;
grant delete on deao_t to tiptop;
grant insert on deao_t to tiptop;

exit;
