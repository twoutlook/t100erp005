/* 
================================================================================
檔案代號:deam_t
檔案名稱:營業款保全代收存繳單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table deam_t
(
deament       number(5)      ,/* 企業編號 */
deamsite       varchar2(10)      ,/* 營運據點 */
deamunit       varchar2(10)      ,/* 應用組織 */
deamdocno       varchar2(20)      ,/* 存繳單號 */
deamdocdt       date      ,/* 單據日期 */
deam001       varchar2(10)      ,/* 保全編號 */
deamownid       varchar2(20)      ,/* 資料所有者 */
deamowndp       varchar2(10)      ,/* 資料所屬部門 */
deamcrtid       varchar2(20)      ,/* 資料建立者 */
deamcrtdp       varchar2(10)      ,/* 資料建立部門 */
deamcrtdt       timestamp(0)      ,/* 資料創建日 */
deammodid       varchar2(20)      ,/* 資料修改者 */
deammoddt       timestamp(0)      ,/* 最近修改日 */
deamstus       varchar2(10)      ,/* 狀態碼 */
deamcnfid       varchar2(20)      ,/* 資料確認者 */
deamcnfdt       timestamp(0)      ,/* 資料確認日 */
deamud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deamud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deamud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deamud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deamud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deamud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deamud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deamud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deamud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deamud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deamud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deamud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deamud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deamud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deamud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deamud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deamud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deamud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deamud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deamud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deamud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deamud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deamud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deamud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deamud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deamud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deamud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deamud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deamud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deamud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table deam_t add constraint deam_pk primary key (deament,deamdocno) enable validate;

create unique index deam_pk on deam_t (deament,deamdocno);

grant select on deam_t to tiptop;
grant update on deam_t to tiptop;
grant delete on deam_t to tiptop;
grant insert on deam_t to tiptop;

exit;
