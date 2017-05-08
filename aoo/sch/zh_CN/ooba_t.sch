/* 
================================================================================
檔案代號:ooba_t
檔案名稱:單據別主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooba_t
(
oobastus       varchar2(10)      ,/* 狀態碼 */
oobaent       number(5)      ,/* 企業編號 */
ooba001       varchar2(5)      ,/* 參照表編號 */
ooba002       varchar2(5)      ,/* 單據別編號 */
ooba008       varchar2(1)      ,/* 可用From */
ooba009       varchar2(1)      ,/* 可用To */
ooba010       varchar2(1)      ,/* MRP可用From */
ooba011       varchar2(1)      ,/* MRP可用To */
ooba012       varchar2(1)      ,/* 成本倉From */
ooba013       varchar2(1)      ,/* 成本倉To */
oobaownid       varchar2(20)      ,/* 資料所有者 */
oobaowndp       varchar2(10)      ,/* 資料所屬部門 */
oobacrtid       varchar2(20)      ,/* 資料建立者 */
oobacrtdp       varchar2(10)      ,/* 資料建立部門 */
oobacrtdt       timestamp(0)      ,/* 資料創建日 */
oobamodid       varchar2(20)      ,/* 資料修改者 */
oobamoddt       timestamp(0)      ,/* 最近修改日 */
ooba014       varchar2(1)      ,/* 產品分類-正/負向表列 */
ooba015       varchar2(1)      ,/* 理由碼-正/負向表列 */
oobaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oobaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oobaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oobaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oobaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oobaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oobaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oobaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oobaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oobaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oobaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oobaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oobaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oobaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oobaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oobaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oobaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oobaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oobaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oobaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oobaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oobaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oobaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oobaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oobaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oobaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oobaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oobaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oobaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oobaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
ooba016       varchar2(255)      /* 備註 */
);
alter table ooba_t add constraint ooba_pk primary key (oobaent,ooba001,ooba002) enable validate;

create unique index ooba_pk on ooba_t (oobaent,ooba001,ooba002);

grant select on ooba_t to tiptop;
grant update on ooba_t to tiptop;
grant delete on ooba_t to tiptop;
grant insert on ooba_t to tiptop;

exit;
