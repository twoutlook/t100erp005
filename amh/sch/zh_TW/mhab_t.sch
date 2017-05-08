/* 
================================================================================
檔案代號:mhab_t
檔案名稱:樓層基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table mhab_t
(
mhabent       number(5)      ,/* 企業編號 */
mhabsite       varchar2(10)      ,/* 營運據點 */
mhabunit       varchar2(10)      ,/* 應用組織 */
mhab001       varchar2(10)      ,/* 樓棟編號 */
mhab002       varchar2(10)      ,/* 樓層編號 */
mhab003       number(20,6)      ,/* 建築面積 */
mhab004       number(20,6)      ,/* 測量面積 */
mhab005       number(20,6)      ,/* 經營面積 */
mhab006       number(20,6)      ,/* 圖紙建築面積 */
mhab007       number(20,6)      ,/* 圖紙測量面積 */
mhab008       number(20,6)      ,/* 建築公攤率 */
mhab009       number(20,6)      ,/* 公攤系數 */
mhabownid       varchar2(20)      ,/* 資料所有者 */
mhabowndp       varchar2(10)      ,/* 資料所屬部門 */
mhabcrtid       varchar2(20)      ,/* 資料建立者 */
mhabcrtdp       varchar2(10)      ,/* 資料建立部門 */
mhabcrtdt       timestamp(0)      ,/* 資料創建日 */
mhabmodid       varchar2(20)      ,/* 資料修改者 */
mhabmoddt       timestamp(0)      ,/* 最近修改日 */
mhabstus       varchar2(10)      ,/* 狀態碼 */
mhabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mhabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mhabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mhabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mhabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mhabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mhabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mhabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mhabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mhabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mhabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mhabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mhabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mhabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mhabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mhabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mhabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mhabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mhabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mhabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mhabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mhabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mhabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mhabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mhabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mhabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mhabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mhabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mhabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mhabud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mhab_t add constraint mhab_pk primary key (mhabent,mhab001,mhab002) enable validate;

create unique index mhab_pk on mhab_t (mhabent,mhab001,mhab002);

grant select on mhab_t to tiptop;
grant update on mhab_t to tiptop;
grant delete on mhab_t to tiptop;
grant insert on mhab_t to tiptop;

exit;
