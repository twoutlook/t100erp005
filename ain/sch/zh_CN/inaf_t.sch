/* 
================================================================================
檔案代號:inaf_t
檔案名稱:庫位料件設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table inaf_t
(
inafent       number(5)      ,/* 企業編號 */
inafsite       varchar2(10)      ,/* 營運據點 */
inaf001       varchar2(10)      ,/* 庫位編號 */
inaf002       varchar2(10)      ,/* 儲位編號 */
inaf003       varchar2(40)      ,/* 料件編號 */
inaf004       varchar2(256)      ,/* 產品特徵 */
inaf005       varchar2(10)      ,/* 庫存單位 */
inaf006       number(20,6)      ,/* 安全庫存量 */
inaf007       number(20,6)      ,/* 補給點量 */
inaf008       number(20,6)      ,/* 補給量 */
inaf009       number(5,0)      ,/* 有效期限(月) */
inaf010       number(5,0)      ,/* 有效期限(天) */
inafownid       varchar2(20)      ,/* 資料所有者 */
inafowndp       varchar2(10)      ,/* 資料所屬部門 */
inafcrtid       varchar2(20)      ,/* 資料建立者 */
inafcrtdp       varchar2(10)      ,/* 資料建立部門 */
inafcrtdt       timestamp(0)      ,/* 資料創建日 */
inafmodid       varchar2(20)      ,/* 資料修改者 */
inafmoddt       timestamp(0)      ,/* 最近修改日 */
inafstus       varchar2(10)      ,/* 狀態碼 */
inaf011       date      ,/* 最近盤點日 */
inafud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inafud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inafud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inafud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inafud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inafud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inafud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inafud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inafud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inafud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inafud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inafud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inafud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inafud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inafud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inafud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inafud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inafud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inafud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inafud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inafud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inafud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inafud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inafud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inafud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inafud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inafud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inafud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inafud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inafud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inaf_t add constraint inaf_pk primary key (inafent,inafsite,inaf001,inaf002,inaf003,inaf004) enable validate;

create unique index inaf_pk on inaf_t (inafent,inafsite,inaf001,inaf002,inaf003,inaf004);

grant select on inaf_t to tiptop;
grant update on inaf_t to tiptop;
grant delete on inaf_t to tiptop;
grant insert on inaf_t to tiptop;

exit;
